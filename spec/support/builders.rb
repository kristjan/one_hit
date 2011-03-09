require 'fixjour'
require 'ffaker'


Fixjour do
  define_builder(Quip) do |klass, overrides|
    klass.new(
      :site => new_site,
      :text => Faker::Lorem.sentence(3)
    )
  end

  define_builder(Site) do |klass, overrides|
    klass.new(
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
end
