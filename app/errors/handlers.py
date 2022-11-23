from flask import Blueprint, render_template


errors = Blueprint('errors', __name__)

# For 404 error page
@errors.app_errorhandler(404)
def page_not_found(error):
    return render_template('error.html', err_msg='404 page not found'), 404

# For 403 error page
@errors.app_errorhandler(403)
def access_denied(error):
    return render_template('error.html', err_msg='403 invalid credentials'), 403

# For 405 error page
@errors.app_errorhandler(500)
def internal_error(error):
    return render_template('error.html', err_msg='500 internal server error'), 500
