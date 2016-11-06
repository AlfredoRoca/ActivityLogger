# == Schema Information
#
# Table name: gittags
#
#  id                :integer          not null, primary key
#  commit            :string
#  date              :datetime
#  description       :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  project_id        :integer
#  activity_duration :string
#

require 'rails_helper'

RSpec.describe Gittag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
