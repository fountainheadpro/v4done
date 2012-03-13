require 'factory_girl'

FactoryGirl.define do
  factory :user, aliases: [:creator] do
    sequence(:name) { |n| "Test User #{n}"}
    sequence(:email) { |n| "user#{n}@test.com"}
    password 'please'
  end

  factory :template do
    creator
    sequence(:title) { |n| "Template #{n}" }

    factory :template_with_subitems do
      ignore do
        items_count 2
        subitems_count 3
      end

      after_create do |template, evaluator|
        item = nil
        evaluator.items_count.times do |i|
          item = template.items.create title: "Item #{i}", previous_id: item.try(:id)
          subitem = nil
          evaluator.subitems_count.times do |j|
            subitem = template.items.create title: "Subitem #{j}", parent_id: item.id, previous_id: subitem.try(:id)
          end
        end
      end
    end
  end

  factory :publication do
    creator
    template { Factory.create(:template_with_subitems, creator: creator) }
  end
end