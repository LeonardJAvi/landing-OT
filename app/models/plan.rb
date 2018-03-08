# Plan Model
class Plan < ActiveRecord::Base
  include ActivityHistory
  include CloneRecord
  require 'csv'
  mount_uploader :banner, AttachmentUploader
  acts_as_list
  belongs_to :destination

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  # validates_presence_of :title, :days, :url, :destination_id, price: [ :cop, :usd ], :banner

  serialize :price

  def self.search_price(id, currency, minimo, maximo)
    Plan.select {|plan| plan.destination_id == id.to_s && plan.price[currency] >= minimo && plan.price[currency] <= maximo}
  end

  # Fields for the search form in the navbar
  def self.search_field
    :banner_or_title_or_subtitle_or_days_or_url_or_destination_id_cont
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      begin
        Plan.create! row.to_hash
      rescue => err
      end
    end
  end
end
