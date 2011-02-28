require 'fixjour'
require 'ffaker'


Fixjour do
  define_builder(Site) do |klass, overrides|
    klass.new(
      :name => Faker::Lorem.sentence(3),
      :slug => Faker::Lorem.word.downcase
    )
  end

  define_builder(Quip) do |klass, overrides|
    klass.new(
      :site => new_site,
      :text => Faker::Lorem.sentence(3)
    )
  end
end
