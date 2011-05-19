class ExtractPagesDataset < Dataset::Base
  uses :home_page

  def load
    create_page 'News', :class_name => 'ArchivePage' do
      create_page 'Article 1', :published_at => DateTime.parse('2000-12-01 08:41:07')
      create_page 'Article 2', :published_at => DateTime.parse('2001-02-09 08:42:04')
      create_page 'Article 3', :published_at => DateTime.parse('2001-02-24 12:02:43')
      create_page 'Article 4', :published_at => DateTime.parse('2001-03-06 03:32:31')
    end
  end
end
