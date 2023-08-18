# frozen_string_literal: true

require_relative "timestamp_uuid/version"
require "securerandom"

# This is a UUID V4 compliant timestamp uuid with millisecond precision, for
# which also the string representation is correctly sorted by encoded timestamp
# (in contrast to time uuids used by e.g. cassandra)

class TimestampUuid
  MUTEX = Mutex.new
  @@sequence_number = 0

  def self.generate(timestamp = Time.now)
    # The timestamp occupies 56 bit, such that it roughly works for the next 2
    # million years (from year 2022 on) with millisecond precision:
    #
    # ((Time.parse("2022-01-01") + 2_000_000.years).to_f * 1_000).to_i
    # => 63114068099520000
    # 16 ** 14
    # => 72057594037927936
    timestamp_part = "%014x" % (timestamp.to_f * 1_000).to_i

    # The sequence number takes 20 bit, such that roughly 1 million uuids could
    # be generated per millisecond max while having the correct sort order
    sequence_number_part = "%05x" % MUTEX.synchronize { @@sequence_number = (@@sequence_number + 1) % 1_048_575 }

    # The random part takes 48 bit
    random_part = SecureRandom.hex[0, 12]

    # The version takes 8 bit
    version_part = "4"

    hex = [timestamp_part, sequence_number_part, random_part].join.insert(12, version_part)

    [hex[0, 8], hex[8, 4], hex[12, 4], hex[16, 4], hex[20, 12]].join("-")
  end

  attr_reader :timestamp

  def initialize(uuid)
    clean_uuid = uuid.gsub(/-/, "")

    @uuid = uuid
    @timestamp = Time.at("#{ clean_uuid[0, 12] }#{ clean_uuid[13, 2] }".to_i(16) / 1_000.0)
    @version = clean_uuid[12].to_i(16)
    @sequence_number = clean_uuid[15, 5].to_i(16)
  end

  def to_s
    @uuid
  end
end
