class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   include BuildCustomUrl



  validates :first_name, :last_name, :full_name, :email, :password,
              :country_code, :contact, :full_contact, presence: true
    
   validates :full_name,presence: true,
              format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ },
              length: { minimum:5, maximum: 30,
              message: "%{value} verifier votre nom complet"}

   include BuildCustomUrl
             

   ################## SLUG ###############
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  
  def should_generate_new_friendly_id?
    full_name_changed?
  end 
 
  
  ################## BEFORE SAVE  #########
  before_save do
    #self.country            = country.strip.squeeze(" ")
    self.contact            = contact.strip.squeeze(" ")
    self.first_name         = first_name.strip.squeeze(" ").downcase.capitalize
    self.last_name          = last_name.strip.squeeze(" ").downcase.capitalize
  end
end
