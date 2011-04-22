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

  define_builder(Badge::TestPilot, :as => :badge) do |klass, overrides|
    klass.new(
      :user => new_user
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
      :url  => Faker::Lorem.words(5).join.downcase
    )
  end

  define_builder(User) do |klass, overrides|
    klass.new(
      :name => Faker::Name.name,
      :email => Faker::Internet.email
    )
  end

  def new_views(overrides={})
    new_site.views.tap do |views|
      overrides.each {|attr, value| views.send("#{attr}=", value) }
    end
  end

  # Rails v3.0.6 has a bug wherin if you initialize an owner object and a
  # target linked by has_one, then save both, the finder_sql isn't update when
  # the owner acquires an ID. Work around it by explicitly loading a fresh Views
  # object, thereby avoiding the AssociationProxy.
  def create_views(overrides={})
    views = new_views(overrides)
    views.site.save
    Views.find(views.id)
  end

end
