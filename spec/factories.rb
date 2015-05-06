FactoryGirl.define do  factory :user_notification do
    
  end
  factory :notification do
    
  end
  factory :picture do
    
  end



  factory :chore do
    task "do dishes"
    house
  end

  factory :chore_log do
    user
    chore

    factory :chores_with_logs do
      transient do
        chore_count 2
      end
      after(:create) do |chore_log, evaluator|
        create_list(:chore_log, evaluator.chore_count, chore: chore)
      end
    end
  end

  factory :chore_issue, class: "Issue" do
    association :issuable, :factory => :chore
    reason "I hate Paul!"
    user
  end

  factory :chore_promise, class: "UserPromise" do
    association :promisable, :factory => :chore
    user
  end

  factory :housing_assignment do
    user
    house
  end
  #### Chore End
  factory :event do
    name "halloween"
    date "2013-09-12 22:49:27"
    description "Costume party!!"
    housing_assignment
  end


  factory :event_issue, class: "Issue" do
    association :issuable, :factory => :event
    reason "I hate halloween"
    user
  end

  #EVENT END
  factory :communal_item do
    name "toilet paper"
    house
    stock_level "low"
  end

  factory :item_issue, class: "Issue" do
    association :issuable, :factory => :communal_item
    reason "I hate toilet paper"
    user
  end

  factory :communal_item_promise, class: "UserPromise" do
    association :promisable, :factory => :communal_item
    user
  end

  ## Communal Item End

  factory :message do
    content "you're the best"
    housing_assignment
  end

  # Message End

  factory :rule do
    content "Flush the toilet"
    # housing_assignment
  end

  factory :rule_issue, class: "Issue" do
    association :issuable, :factory => :rule
    reason "I hate flushing!"
    user
  end

  # Rule End


  factory :house do
    name "The hater house"
    house_key "123456"
    address
    property_manager

    factory :house_with_housing_assignments do
      transient do
        housing_assignment_count 2
      end

      factory :house_with_chores do
        transient do
          house_chores_count 2
        end

        factory :house_with_communal_items do
          transient do
            house_items_count 2
          end

          after(:create) do |house, evaluator|
            create_list(:housing_assignment, evaluator.housing_assignment_count, house: house)
            create_list(:chore, evaluator.house_chores_count, house: house)
            create_list(:communal_item, evaluator.house_items_count, house: house)
          end
        end
      end
    end
  end

  factory :property_manager do
    name "Tom"
    phone "773-606-6186"
    address
  end

  factory :address do
    street "1462 W Carmen Ave Apt 2"
    city "Chicago"
    state "IL"
    zip_code "60640"

    factory :address_with_manager do
      transient do
        property_manager_count 1
      end

      factory :address_with_house do
        transient do
          house_count 1
        end

        after(:create) do |address, evaluator|
          create_list(:property_manager, evaluator.property_manager_count, address: address)
          create_list(:house, evaluator.house_count, address: address)
        end
      end
    end
  end

  factory :user do
    first_name "Paul"
    last_name "Clegg"
    email "clegg@clegg.com"
    password "123456"

    factory :user_chore_logs do
      transient do
        chore_log_count 2
      end

      factory :user_chore_issues do
        transient do
          chore_issue_count 2
        end

        factory :user_chore_promise do
          transient do
            chore_promise_count 2
          end

          factory :user_event_issues do
            transient do
              event_issue_count 2
            end

            factory :user_item_issues do
              transient do
                item_issue_count 2
              end

              factory :user_item_promises do
                transient do
                  item_promise_count 2
                end

                factory :user_rule_issues do
                  transient do
                    rule_issue_count 2
                  end

                  factory :user_housing_ass do
                    transient do
                      house_ass_count 2
                    end

                    after(:create) do |user, evaluator|
                      create_list(:chore_log, evaluator.chore_log_count, user: user)
                      create_list(:chore_issue, evaluator.chore_issue_count, user: user)
                      create_list(:chore_promise, evaluator.chore_promise_count, user: user)
                      create_list(:event_issue, evaluator.event_issue_count, user: user)
                      create_list(:item_issue, evaluator.item_issue_count, user: user)
                      create_list(:communal_item_promise, evaluator.item_promise_count, user: user)
                      create_list(:rule_issue, evaluator.rule_issue_count, user: user)
                      create_list(:housing_assignment, evaluator.housing_ass_count, user: user)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
#User Factories
# :chore_log
# :chore_issue
# :chore_promise
# :event_issue
# :item_issue
# :communal_item_promise
# :rule_issue
# :housing_assignment
