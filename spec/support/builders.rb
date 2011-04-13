require 'fixjour'
require 'ffaker'


Fixjour do
  define_builder(Authorization) do |klass, overrides|
    klass.new(
      :user     => new_user,
      :provider => Faker::Lorem.word.downcase,
      :uid      => Faker::Lorem.word.downcase,
      :token    => Faker::Lorem.sentence.gsub(/\s+/, ''),
      :secret   => Faker::Lorem.sentence.gsub(/\s+/, '')
    )
  end

  define_builder(Quip) do |klass, overrides|
    klass.new(
      :site => new_site,
      :text => Faker::Lorem.sentence(3)
    )
  end

  define_builder(Site) do |klass, overrides|
    klass.new(
      :creator => new_user,
      :name => Faker::Lorem.sentence(3),
      :url  => Faker::Lorem.words(2).join.downcase
    )
  end

  define_builder(User) do |klass, overrides|
    klass.new(
      :name => Faker::Name.name,
      :email => Faker::Internet.email
    )
  end

  define_builder(Views) do |klass, overrides|
    klass.new(
      :site => new_site
    )
  end

end
