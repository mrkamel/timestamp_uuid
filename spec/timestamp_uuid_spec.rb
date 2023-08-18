# frozen_string_literal: true

RSpec.describe TimestampUuid do
  describe ".generate" do
    it "generates a uuid for the specified timestamp" do
      timestamp = Time.now

      expect(described_class.new(described_class.generate(timestamp)).timestamp.to_f.floor(2)).to eq(timestamp.to_f.floor(2))
    end

    it "generates a valid uuid" do
      expect(described_class.generate).to match(/\A[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}\Z/)
    end

    it "generates lexicographically sortable uuids" do
      uuid1 = described_class.generate(Time.now - 86_400)
      uuid2 = described_class.generate(Time.now + 86_400)
      uuid3 = described_class.generate(Time.now)
      uuid4 = described_class.generate(Time.now)

      expect([uuid1, uuid2, uuid3, uuid4].sort).to eq([uuid1, uuid3, uuid4, uuid2])
    end
  end

  describe "#initialize" do
    it "parses the timestamp uuid" do
      timestamp = Time.now.utc

      expect(described_class.new(described_class.generate(timestamp)).timestamp.to_f.floor(2)).to eq(timestamp.to_f.floor(2))
    end
  end

  describe "#to_s" do
    it "returns the string representation" do
      uuid = described_class.generate

      expect(described_class.new(uuid).to_s).to eq(uuid)
    end
  end
end
