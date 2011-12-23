module TemplateStepsHelpers
  def create_templates(user)
    @templates = []
    ["Apple pie", "Pumpkin Pie", "Cheesecake"].each do |title|
      @templates << user.templates.create(title: title)
    end
  end
end

World(TemplateStepsHelpers)