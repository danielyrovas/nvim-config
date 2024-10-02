---@diagnostic disable: undefined-global

return {
    s(
        "firefly json to json",
        fmt(
            [[require "json"
require "httparty"

def fetch_jobs(page)
  $%
rescue StandardError => e
  logger.info(e.message)
  nil
end

count = nil
jobs = []

(0..2).each do |page|
  data = fetch_jobs(page)
  break if data.nil? || data["jobs"].nil? || data["jobs"].empty?
  count = data["count"] if page == 0

  data["jobs"].each do |row|
    jobs <<
      {
        id: row["id"],
        url: row["link"],
        title: row["title"],
        location: row["loc"],
        type: row["jobType"],
        description: row["description"],
        posted: row["datePosted"],
        expiry: row["postEndDate"]
      }
  end
end

File.write(FILE, JSON.generate({ count: count, jobs: jobs.flatten }))
{ output_file: FILE }]],
            { i(1, "res = HTTParty.get(url)") },
            { delimiters = "$%" }
        )
    ),
    s(
        "firefly html to html",
        fmt(
            [[require "json"
require "httparty"

def fetch_jobs(page)
  $%
rescue StandardError => e
  logger.info(e.message)
  nil
end

count = nil
content = "<html><body>\n"

(0..2).each do |page|
  data = fetch_jobs(page)
  break if data.nil? || data.search("jobs").empty?
  content += "<p class='count'>#{jobs.at('')}</p>\n" if page == 0
  data["results"].each do |row|
    content += "<div>\n<p class='id'>#{row.at('uuid')}</p>
      <a href='#{url}'>#{row.at('title')}</a>
      <p class='location'>#{}</p>
      <p class='created'>#{row.at('created')}</p>
      <p class='expiry'>#{}</p>
      <p class='type'>#{}</p>
      <div class='description'>#{}</div>
      <p class='source'>#{}</p>
    </div>"
  end
end

content += "\n</body></html>"

File.write(FILE, content)
{ output_file: FILE }]],
            { i(1, "res = HTTParty.get(url)") },
            { delimiters = "$%" }
        )
    ),
    s(
        "firefly json to html",
        fmt(
            [[require "json"
require "httparty"

def fetch_jobs(page)
  $%
rescue StandardError => e
  logger.info(e.message)
  nil
end

count = nil
content = "<html><body>\n"

(0..2).each do |page|
  data = fetch_jobs(page)
  break if data.nil? || data['jobs'].empty
  content += "<p class='count'>#{data['jobcount']}</p>\n" if page == 0
  data["jobs"].each do |row|
    content += "<div>\n<p class='id'>#{row['uuid']}</p>
      <a href='#{url}'>#{row['title']}</a>
      <p class='location'>#{}</p>
      <p class='created'>#{}</p>
      <p class='expiry'>#{}</p>
      <p class='type'>#{}</p>
      <div class='description'>#{}</div>
      <p class='source'>#{}</p>
    </div>"
  end
end

content += "\n</body></html>"

File.write(FILE, content)
{ output_file: FILE }]],
            { i(1, "res = HTTParty.get(url)") },
            { delimiters = "$%" }
        )
    ),
}
