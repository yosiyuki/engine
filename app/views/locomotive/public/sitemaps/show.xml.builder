xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc current_site_public_url
    xml.priority 1.0
  end

  @pages.each do |page|
    if not page.index_or_not_found?
      if page.templatized?
        page.fetch_target_entries(_visible: true).each do |c|
          xml.url do
            xml.loc public_page_url(page, { content: c })
            xml.lastmod c.updated_at.to_date.to_s('%Y-%m-%d')
            xml.priority 0.9
          end
        end
      else
        xml.url do
          xml.loc public_page_url(page)
          xml.lastmod page.updated_at.to_date.to_s('%Y-%m-%d')
          xml.priority 0.9
        end
      end
    end
  end

end
