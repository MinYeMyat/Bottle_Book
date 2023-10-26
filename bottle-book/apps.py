from email.mime import application
import bottle
# 各パスルーティング
import routes
import routes_form
import routes_list
import routes_login
from utils.session import Session

app = routes.app
app_sess = routes.app_sess

if __name__ == '__main__':
    # This setting is for running in development.
    bottle.run(app=app_sess, host='0.0.0.0', port=8888, reloader=True, debug=True)
else:
    # Add the following line for WSGI application deployment
    application = app_sess
    
