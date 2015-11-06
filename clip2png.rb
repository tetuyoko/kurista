require 'sqlite3'

OUTPUT_FILE_NAME = "hoge.png"
INPUT_CLIP_NAME = "fixegirls.clip"
SQL_STMT = "select ImageData From CanvasPreview"

# INPUT_CLIP_NAMEファイルをSQLチャンクを抜く

db = SQLite3::Database.new INPUT_CLIP_NAME
rows = db.execute(SQL_STMT)
data = rows[0][0]
File.write(OUTPUT_FILE_NAME, data)

open OUTPUT_FILE_NAME
