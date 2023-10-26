
from bottle import Bottle, jinja2_template as template, \
request, redirect
from bottle import response 
import routes
from models import connection, Book
from utils.auth import Auth 
import urllib.parse as urlpar
#routesからappを読み込む
app = routes.app
auth = Auth()

@app.route('/list')
def list():
#・ リスト画面を表示する
#・DBから書籍リストの取得
#認証確認
    auth.check_login()
    
    bookList = connection.query(Book.name,
                            Book. volume, Book.author, 
                            Book.publisher, Book.memo,
                            Book.id_)\
            .filter(Book.delFlag == False).all()
    headers = ['書名', '卷数', '著者', '出版社', 'メモ', '操作']
    return template('list.html', bookList=bookList, headers=headers)
