require 'sqlite3'

OUTPUT_FILE_NAME = "kaiji.png".freeze
INPUT_CLIP_NAME = "kaiji.clip".freeze
TMP_CLIP_NAME = "kaiji.sqlite".freeze
SQL_STMT = "select ImageData From CanvasPreview".freeze
SQL_BEGIN = "SQLite format 3".freeze

def extract_clip(path)
  begin
    found = false
    output_path = "#{path}.sqlite"
    f = File.new(output_path, "w")

    File.open(path) do |file|
      file.each_line do |labmen|
        unless found
          if idx = labmen.index(SQL_BEGIN)
            found = true
            f.puts labmen[idx ..-1]
          end
        else
          f.puts labmen
        end
      end
    end

    return output_path

  rescue SystemCallError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  rescue IOError => e
    puts %Q(class=[#{e.class}] message=[#{e.message}])
  ensure
    f.close
  end
end

def main
  path = "kaiji.clip"

  unless output_path = extract_clip(path)
    raise "error occured"
  end

  db = SQLite3::Database.new output_path
  rows = db.execute(SQL_STMT)
  data = rows[0][0]
  File.write("#{path}.png", data)
  `rm #{output_path}`
end

main
