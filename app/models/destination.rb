# Destination Model
class Destination < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  require 'csv'
  mount_uploader :banner, AttachmentUploader
  acts_as_list

  has_many :hotels
  has_many :plans
  has_many :excursions

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  validates_presence_of :name, :banner

  def self.name_destiny(name)
    Destination.find(name).name
  end

  def filter_letter(name)
    return name.first.downcase
  end

  def self.hotels(destination)
    destination.hotels.count
  end

  def self.plans(destination)
    destination.plans.count
  end

  def self.excursions(destination)
    destination.excursions.count
  end

  # Fields for the search form in the navbar
  def self.search_field
    :name_cont
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      begin
        Destination.create! row.to_hash
      rescue => err
      end
    end
  end
end
