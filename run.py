from app import app

# Run the server at 1200 and allow connections form all hosts
if __name__ == "__main__":
    app.run(port=12000, debug=True, host='0.0.0.0')
