class ImportedUser < ActiveRecord::Base
  belongs_to :applicant

  before_create :set_key

  def set_key
    self.key = SecureRandom.uuid + SecureRandom.uuid
  end

  def to_param
    self.key
  end

  def to_s
    "Found, key: #{key}"
  end


end
