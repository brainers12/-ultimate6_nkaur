class Customer < ApplicationRecord
  # Adds an attachment reference for the image. This assumes you will only have one image per customer.
  has_one_attached :image
  
  # Validations
  validates :full_name, presence: true

  # If you want to ensure the uniqueness of email addresses:
  validates :email_address, uniqueness: true, allow_blank: true

  # If you want to validate the format of the email address (simple regex example):
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  # Existing ransackable_attributes method.

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email_address", "full_name", "id", "notes", "phone_number", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    [] # Return an empty array if there are no associations to search or specify the associations
  end

end

