class BasePresenter
  @build_attributes = []
  attr_accessor :object, :params, :data

  def initialize(object, params, options = {})
    @object = object
    @params = params
    @options = options
    @data = HashWithIndifferentAccess.new
  end

  def as_json(*)
    @data
  end

  class << self
    attr_accessor :build_attributes

    def build_with(*args)
      @build_attributes = args.map(&:to_s)
    end
  end
end
