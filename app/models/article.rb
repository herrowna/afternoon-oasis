class Article < ApplicationRecord
  has_one_attached :image

  def Article.create_new_image(article_params) # :title & :description
    article = Article.new(article_params)
    processor = ::OmgImage::Processor.new('simple', article_params)
    processor.with_screenshot do |screenshot|
      article.image.attach(io: File.open(screenshot.path), filename: "image.png", content_type: "image/png") # attach an image to article via ActiveStorage
    article.save!
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
