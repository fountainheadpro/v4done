module PublicationHelper

  @@MAX_TEXT_LENGTH=500

  def shrink_description(description, id)
    #description=p.template.description
    return nil unless description.present?
    shrunk_description = Nokogiri::HTML::DocumentFragment.parse ""
    doc = Nokogiri::HTML(description)
    first_image=doc.xpath('//img').first
    image_path=first_image['src'] if first_image.present?
    text=""
    doc.xpath("//div//text()", "//p//text()","//span//text()").each do |el|
      text_before=text
      text += " " + el.text()
      if text.length>@@MAX_TEXT_LENGTH
        text=text_before
        break
      end
    end
    Nokogiri::HTML::Builder.with(shrunk_description) do |doc|
    doc.html {
        doc.div{
          doc.img(src: image_path, class: 'preview', align: 'left') if first_image.present?
          doc.span{
            doc.text text+" ..."
          }
          doc.a(href: publication_path(id), class: "more_link"){
            doc.text "   (more)"
          }
        }
    }
    end
    shrunk_description.to_html()
  end

end