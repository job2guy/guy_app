class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name, :null => false
      t.string :title, :null => false
      t.timestamps
    end
    
    Language.find_or_create_by_name(:name => 'ror',:title => 'Ruby/Ruby On Rails')
    Language.find_or_create_by_name(:name => 'net',:title => '.Net(VB,C#,ASP)')
    Language.find_or_create_by_name(:name => 'java',:title => 'Java/J2EE(Spring/Struts/JSP/JavaBeans/Servlet)')
    Language.find_or_create_by_name(:name => 'j2me',:title => 'J2ME')
    Language.find_or_create_by_name(:name => 'brew',:title => 'BREW')
    Language.find_or_create_by_name(:name => 'androit',:title => 'Androit')
    Language.find_or_create_by_name(:name => 'database',:title => 'Database(MySQL,PostgreSQL,Oracle')
    Language.find_or_create_by_name(:name => 'web',:title => 'Web Design(HTML,CSS,Photoshop,XHTML,Javascript)')
    Language.find_or_create_by_name(:name => 'php',:title => 'PHP(Drupal/Joomla)')
    Language.find_or_create_by_name(:name => 'test',:title => 'Testing')
    Language.find_or_create_by_name(:name => 'other',:title => 'Others')
    puts "Languages created."
  end

  def self.down
    drop_table :languages
  end
end
