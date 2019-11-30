class Lesson < ApplicationRecord
  mount_uploader :video, VideoUploader
  belongs_to :section
  include RankedModel
  ranks :row_order, with_same: :section_id
end
