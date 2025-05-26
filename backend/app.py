from flask import Flask, request, session, jsonify, render_template ,Response
from werkzeug.security import check_password_hash
from flask_wtf.csrf import CSRFProtect
from forms import SignUpForm
from flask_cors import CORS
from models import db, WatchLater, Show
from functions import sqlite_execute_query , split_by_type, mysql_execute_query
import json

# new
from functools import wraps
app = Flask(__name__)
app.config.from_object("config.Config")
from flask_session import Session

# CORS(app)  # Enable CORS for frontend requests
CORS(app, supports_credentials=True)
csrf = CSRFProtect(app)  # Protect against CSRF attacks
app.secret_key = "secret_key"
# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
app.config.update(
    SESSION_COOKIE_SAMESITE='None',
    SESSION_COOKIE_SECURE=True
)
# app.config['DEBUG'] = True
Session(app)
# sqlite3.connect('prime_video.db')
database = "prime_video.db"
# mysql_config
# db_config = {
#     'host': 'localhost',
#     'user': 'root',
#     'password': 'your_password',
#     'database': 'your_database'
# }

# db_config = {
#     'host':'127.0.0.1',
#     'user':'root',
#     'password':'Ms@228823',
#     'database':'system_users'
# }
# db_config = {
#     'host': '127.0.0.1',
#     'user': 'root',
#     'password': 'Ms@228823',
#     'database': 'prime-video'
# }
# query = "SELECT * FROM test;"
# result = mysql_execute_query(db_config, query, fetch=True)
# print("MySQL Query Result:", result)


@app.route("/", methods=["GET"])
def main():
    return jsonify({"message": "Welcome to Prime Video API"}), 200

@csrf.exempt
@app.route("/api/signin", methods=["POST", "GET"])
@app.route("/api/SignIn", methods=["GET", "POST"])
def signin():
    # test
    # query = "SELECT * FROM user"
    # rows = sqlite_execute_query(database, query, fetch=True)
    # print(rows)
    if request.method == "POST":

        # Execute query to fetch user by username
        if not request.is_json:
            return jsonify({"error": "Request must be JSON"}), 400
        if request.form:
            username = request.form.get("username")
            password = request.form.get("password")
        data = request.get_json()
        username = data.get("username")
        password = data.get("password")
        # print("Headers:", dict(request.headers))
        # print("Body:", request.get_data())
        # print("JSON:", request.get_json())
        # print("Headers:", dict(request.headers))
        # print("JSON body:", request.get_json())
        if not username or not password:
            return jsonify({"error": "Missing username or password"}), 400

        # query = "SELECT * FROM user WHERE username = ?"
        # rows = sqlite_execute_query(database, query, request.form.get("username"), fetch=True)
        query = "SELECT * FROM user WHERE email = ?"
        rows = sqlite_execute_query(database, query, username, fetch=True)

        print(rows)
        # Check if the user exists and verify the password (password is hashed in the database)
        # if len(rows) != 1 or not check_password_hash(rows[0][3], request.form.get("password")):
        if len(rows) != 1 or rows[0][3] != password:
            return jsonify({"error": "Invalid username or password"}), 400

        session["user_id"] = rows[0][0]
        print("User ID:", session["user_id"])

        return jsonify({"logged_in": True, "message": "Login successful"}), 200

    elif request.method == "GET":
        print("Cookies:", request.cookies)
        print("Session:", dict(session))
        print("Session content:", dict(session))
        return jsonify({"logged_in": "user_id" in session}), 200
        # return jsonify({"logged_in": session['user_id']}), 200
        
        # return render_template("login.html", {"csrf_token": csrf.generate_csrf()})

    
# SignUp Route
@csrf.exempt
@app.route("/api/signup", methods=["POST","GET"])
def signup():
    # test
    # query = "INSERT INTO user (name, email, password) VALUES (?, ?, ?)"
    # data = ("name", "email_or_phone", "password")
    # sqlite_execute_query(database, query, data)
    # print("done")
    if request.method == "POST":

        # Execute query to fetch user by email
        if not request.is_json:
            return jsonify({"error": "Request must be JSON"}), 400
        if request.form:
            name = request.form.get("name")
            email = request.form.get("email")
            password = request.form.get("password")
            
        data = request.get_json()
        name = data.get("name")
        email = data.get("email")
        password = data.get("password")

        print(email)
        print(name)
        print(password)
        count_query = "SELECT COUNT(id) FROM user"
        count = sqlite_execute_query(database, count_query, fetch=True)[0][0] + 1
        print(count)
        
        # insert into database
        query = "INSERT INTO user (id,name, email, password) VALUES (?, ?, ?, ?)"
        data = (count, name, email, password)
        sqlite_execute_query(database, query, data)
        # conn = sqlite3.connect('prime_video.db')

        
        # Dummy response (In real app, you should store in a database)
        return jsonify({
            "success": True,
            "message": "Account created successfully!",
            "data": {
                "name": name,
                "email_or_phone": email
            }
        }), 201

    return jsonify({"success": False, "message": "Invalid request or missing data"}), 400

@csrf.exempt
@app.route("/api/watch-later/", methods=["GET"])
def get_watch_later():
    """Fetch watch later list for a specific user."""
    # user_id = session["user_id"]
    # test
    watch_later_entries = sqlite_execute_query(database, """
                                               SELECT 
                                                    Show.id AS show_id,
                                                    Show.name AS show_name,
                                                    Show.description AS show_description,
                                                    Show.rating AS show_rating,
                                                    Show.time AS show_duration,
                                                    Show.age_limit AS show_age_limit,
                                                    Show.Category AS show_category_text,
                                                    Show.image AS show_image_url,
                                                    Category.name AS category_name,
                                                    multimedia_type.name AS multimedia_type_name,
                                                    audience_type.name AS audience_type_name
                                                    FROM Show
                                                    JOIN Category ON Show.Category_id = Category.id
                                                    LEFT JOIN multimedia_type ON Show.multimedia_type_id = multimedia_type.id
                                                    LEFT JOIN audience_type ON Show.audience_type_id = audience_type.id
                                                    WHERE Show.id IN (
                                                    SELECT show_id FROM watch_later WHERE user_id = 1
                                                    );
                                               """,fetch=True, is_dict=True)
    # real
    # watch_later_entries = sqlite_execute_query(database, """
    #                                            SELECT 
    #                                                 Show.id AS show_id,
    #                                                 Show.name AS show_name,
    #                                                 Show.description AS show_description,
    #                                                 Show.rating AS show_rating,
    #                                                 Show.time AS show_duration,
    #                                                 Show.age_limit AS show_age_limit,
    #                                                 Show.Category AS show_category_text,
    #                                                 Show.image AS show_image_url,
    #                                                 Category.name AS category_name,
    #                                                 multimedia_type.name AS multimedia_type_name,
    #                                                 audience_type.name AS audience_type_name
    #                                                 FROM Show
    #                                                 JOIN Category ON Show.Category_id = Category.id
    #                                                 LEFT JOIN multimedia_type ON Show.multimedia_type_id = multimedia_type.id
    #                                                 LEFT JOIN audience_type ON Show.audience_type_id = audience_type.id
    #                                                 WHERE Show.id IN (
    #                                                 SELECT show_id FROM watch_later WHERE user_id = ?
    #                                                 );
    #                                            """,user_id,fetch=True, is_dict=True)
                                    
    # select all shows data and category name , multimedia type , and audience type from database based on watch_later entries
    
    if not watch_later_entries:
        return jsonify({"message": "No shows in watch later list"}), 404


    watch_later_response = []
    for watch_later_entry in watch_later_entries:
        watch_later_response.append({
            "show_id": watch_later_entry["show_id"],
            "title": watch_later_entry["show_name"],
            "description": watch_later_entry["show_description"],
            "rating": watch_later_entry["show_rating"],
            "time": watch_later_entry["show_duration"],
            "age_limit": watch_later_entry["show_age_limit"],
            "category_name": watch_later_entry["category_name"],
            "image_url": watch_later_entry["show_image_url"],
            "multimedia_type": watch_later_entry["multimedia_type_name"],
            "audience_type": watch_later_entry["audience_type_name"]
        })
    return jsonify(watch_later_response), 200
    # return jsonify(json.dumps(watch_later_response, indent=2)), 200



@csrf.exempt
@app.route("/api/liked-list/", methods=["GET"])
def liked_list():
    """Fetch Liked list for a specific user."""
    # user_id = session["user_id"]
    # test
    liked_list_entries = sqlite_execute_query(database, """
                                               SELECT 
                                                    Show.id AS show_id,
                                                    Show.name AS show_name,
                                                    Show.description AS show_description,
                                                    Show.rating AS show_rating,
                                                    Show.time AS show_duration,
                                                    Show.age_limit AS show_age_limit,
                                                    Show.Category AS show_category_text,
                                                    Show.image AS show_image_url,
                                                    Category.name AS category_name,
                                                    multimedia_type.name AS multimedia_type_name,
                                                    audience_type.name AS audience_type_name
                                                    FROM Show
                                                    JOIN Category ON Show.Category_id = Category.id
                                                    LEFT JOIN multimedia_type ON Show.multimedia_type_id = multimedia_type.id
                                                    LEFT JOIN audience_type ON Show.audience_type_id = audience_type.id
                                                    WHERE Show.id IN (
                                                    SELECT show_id FROM like WHERE user_id = 1
                                                    );
                                               """,fetch=True, is_dict=True)
    # real
    # liked_list_entries = sqlite_execute_query(database, """
    #                                            SELECT 
    #                                                 Show.id AS show_id,
    #                                                 Show.name AS show_name,
    #                                                 Show.description AS show_description,
    #                                                 Show.rating AS show_rating,
    #                                                 Show.time AS show_duration,
    #                                                 Show.age_limit AS show_age_limit,
    #                                                 Show.Category AS show_category_text,
    #                                                 Show.image AS show_image_url,
    #                                                 Category.name AS category_name,
    #                                                 multimedia_type.name AS multimedia_type_name,
    #                                                 audience_type.name AS audience_type_name
    #                                                 FROM Show
    #                                                 JOIN Category ON Show.Category_id = Category.id
    #                                                 LEFT JOIN multimedia_type ON Show.multimedia_type_id = multimedia_type.id
    #                                                 LEFT JOIN audience_type ON Show.audience_type_id = audience_type.id
    #                                                 WHERE Show.id IN (
    #                                                 SELECT show_id FROM like WHERE user_id = ?
    #                                                 );
    #                                            """,user_id,fetch=True, is_dict=True)
                                    
    # select all shows data and category name , multimedia type , and audience type from database based on watch_later entries
    
    if not liked_list_entries:
        return jsonify({"message": "No shows in watch later list"}), 404


    liked_list_response = []
    for liked_list_entry in liked_list_entries:
        liked_list_response.append({
            "show_id": liked_list_entry["show_id"],
            "title": liked_list_entry["show_name"],
            "description": liked_list_entry["show_description"],
            "rating": liked_list_entry["show_rating"],
            "time": liked_list_entry["show_duration"],
            "age_limit": liked_list_entry["show_age_limit"],
            "category_name": liked_list_entry["category_name"],
            "image_url": liked_list_entry["show_image_url"],
            "multimedia_type": liked_list_entry["multimedia_type_name"],
            "audience_type": liked_list_entry["audience_type_name"]
        })
    return jsonify(liked_list_response), 200
    # return jsonify(json.dumps(liked_list_response, indent=2)), 200


@csrf.exempt
@app.route("/api/disliked-list/", methods=["GET"])
def disliked_list():
    """Fetch disliked later list for a specific user."""
    # user_id = session["user_id"]
    # test
    disliked_list_entries = sqlite_execute_query(database, """
                                               SELECT 
                                                    Show.id AS show_id,
                                                    Show.name AS show_name,
                                                    Show.description AS show_description,
                                                    Show.rating AS show_rating,
                                                    Show.time AS show_duration,
                                                    Show.age_limit AS show_age_limit,
                                                    Show.Category AS show_category_text,
                                                    Show.image AS show_image_url,
                                                    Category.name AS category_name,
                                                    multimedia_type.name AS multimedia_type_name,
                                                    audience_type.name AS audience_type_name
                                                    FROM Show
                                                    JOIN Category ON Show.Category_id = Category.id
                                                    LEFT JOIN multimedia_type ON Show.multimedia_type_id = multimedia_type.id
                                                    LEFT JOIN audience_type ON Show.audience_type_id = audience_type.id
                                                    WHERE Show.id IN (
                                                    SELECT show_id FROM dislike WHERE user_id = 1
                                                    );
                                               """,fetch=True, is_dict=True)
    # real
    # disliked_list_entries = sqlite_execute_query(database, """
    #                                            SELECT 
    #                                                 Show.id AS show_id,
    #                                                 Show.name AS show_name,
    #                                                 Show.description AS show_description,
    #                                                 Show.rating AS show_rating,
    #                                                 Show.time AS show_duration,
    #                                                 Show.age_limit AS show_age_limit,
    #                                                 Show.Category AS show_category_text,
    #                                                 Show.image AS show_image_url,
    #                                                 Category.name AS category_name,
    #                                                 multimedia_type.name AS multimedia_type_name,
    #                                                 audience_type.name AS audience_type_name
    #                                                 FROM Show
    #                                                 JOIN Category ON Show.Category_id = Category.id
    #                                                 LEFT JOIN multimedia_type ON Show.multimedia_type_id = multimedia_type.id
    #                                                 LEFT JOIN audience_type ON Show.audience_type_id = audience_type.id
    #                                                 WHERE Show.id IN (
    #                                                 SELECT show_id FROM dislike WHERE user_id = ?
    #                                                 );
    #                                            """,user_id,fetch=True, is_dict=True)
                                    
    # select all shows data and category name , multimedia type , and audience type from database based on watch_later entries
    
    if not disliked_list_entries:
        return jsonify({"message": "No shows in watch later list"}), 404


    disliked_list_response = []
    for disliked_list_entry in disliked_list_entries:
        disliked_list_response.append({
            "show_id": disliked_list_entry["show_id"],
            "title": disliked_list_entry["show_name"],
            "description": disliked_list_entry["show_description"],
            "rating": disliked_list_entry["show_rating"],
            "time": disliked_list_entry["show_duration"],
            "age_limit": disliked_list_entry["show_age_limit"],
            "category_name": disliked_list_entry["category_name"],
            "image_url": disliked_list_entry["show_image_url"],
            "multimedia_type": disliked_list_entry["multimedia_type_name"],
            "audience_type": disliked_list_entry["audience_type_name"]
        })
    return jsonify(disliked_list_response), 200
    # return jsonify(json.dumps(disliked_list_response, indent=2)), 200




@csrf.exempt
@app.route("/api/blocked-list/", methods=["GET"])
def blocked_list():
    """Fetch blocked later list for a specific user."""
    # user_id = session["user_id"]
    # test
    blocked_list_entries = sqlite_execute_query(database, """
                                               SELECT 
                                                    Show.id AS show_id,
                                                    Show.name AS show_name,
                                                    Show.description AS show_description,
                                                    Show.rating AS show_rating,
                                                    Show.time AS show_duration,
                                                    Show.age_limit AS show_age_limit,
                                                    Show.Category AS show_category_text,
                                                    Show.image AS show_image_url,
                                                    Category.name AS category_name,
                                                    multimedia_type.name AS multimedia_type_name,
                                                    audience_type.name AS audience_type_name
                                                    FROM Show
                                                    JOIN Category ON Show.Category_id = Category.id
                                                    LEFT JOIN multimedia_type ON Show.multimedia_type_id = multimedia_type.id
                                                    LEFT JOIN audience_type ON Show.audience_type_id = audience_type.id
                                                    WHERE Show.id IN (
                                                    SELECT show_id FROM blocked WHERE user_id = 1
                                                    );
                                               """,fetch=True, is_dict=True)
    # real
    # blocked_list_entries = sqlite_execute_query(database, """
    #                                            SELECT 
    #                                                 Show.id AS show_id,
    #                                                 Show.name AS show_name,
    #                                                 Show.description AS show_description,
    #                                                 Show.rating AS show_rating,
    #                                                 Show.time AS show_duration,
    #                                                 Show.age_limit AS show_age_limit,
    #                                                 Show.Category AS show_category_text,
    #                                                 Show.image AS show_image_url,
    #                                                 Category.name AS category_name,
    #                                                 multimedia_type.name AS multimedia_type_name,
    #                                                 audience_type.name AS audience_type_name
    #                                                 FROM Show
    #                                                 JOIN Category ON Show.Category_id = Category.id
    #                                                 LEFT JOIN multimedia_type ON Show.multimedia_type_id = multimedia_type.id
    #                                                 LEFT JOIN audience_type ON Show.audience_type_id = audience_type.id
    #                                                 WHERE Show.id IN (
    #                                                 SELECT show_id FROM blocked WHERE user_id = ?
    #                                                 );
    #                                            """,user_id,fetch=True, is_dict=True)
                                    
    # select all shows data and category name , multimedia type , and audience type from database based on watch_later entries
    
    if not blocked_list_entries:
        return jsonify({"message": "No shows in watch later list"}), 404


    blocked_list_response = []
    for blocked_list_entry in blocked_list_entries:
        blocked_list_response.append({
            "show_id": blocked_list_entry["show_id"],
            "title": blocked_list_entry["show_name"],
            "description": blocked_list_entry["show_description"],
            "rating": blocked_list_entry["show_rating"],
            "time": blocked_list_entry["show_duration"],
            "age_limit": blocked_list_entry["show_age_limit"],
            "category_name": blocked_list_entry["category_name"],
            "image_url": blocked_list_entry["show_image_url"],
            "multimedia_type": blocked_list_entry["multimedia_type_name"],
            "audience_type": blocked_list_entry["audience_type_name"]
        })
        
        # print(json.dumps(blocked_list_response, indent=2))  # Debug print
    return jsonify(blocked_list_response), 200
    # return Response(json.dumps(blocked_list_response), mimetype='application/json')
    # return jsonify(json.dumps(blocked_list_response, indent=2)), 200
    # return jsonify(json.dumps(blocked_list_response, indent=2)), 200




# send all shows categorized (drama,comedy,..) tables show and category form database to frontend
@csrf.exempt
@app.route("/api/tv-shows", methods=["GET"])
def get_shows():
    """Fetch all shows from the database."""
    query = """
                SELECT 
                    s.id AS show_id, 
                    s.name AS show_name, 
                    s.description AS show_description, 
                    s.rating AS show_rating,
                    s.time AS show_duration,
                    s.age_limit AS show_age_limit,
                    s.Category AS show_category_text,
                    s.multimedia_type_id AS show_multimedia_type_id,
                    s.audience_type_id AS show_audience_type_id,
                    s.Category_id AS show_category_id,
                    s.image, 
                    c.name AS category_name
                FROM 
                    Show AS s
                JOIN 
                    Category AS c ON s.Category_id = c.id;


    """
    rows = sqlite_execute_query(database, query, fetch=True)
    if not rows:
        return jsonify({"error": "No shows found"}), 404
    else:
        shows = [{"id": row[0], "title": row[1], "description":
                row[2], "image_url": row[3], "category_name": row[4]} for row in rows]
        return jsonify(shows), 200
    
@csrf.exempt
@app.route("/api/user-data", methods=["GET"])
def userdata():
    # print("session user_id:", session["user_id"])
    """Fetch data for a specific user."""

    # user_data = sqlite_execute_query(database, """SELECT id, name, email FROM user WHERE id = ?""", session["user_id"], fetch=True)
    # test
    user_data = sqlite_execute_query(database, """SELECT id, name, email FROM user WHERE id = 1""", fetch=True)
    
    if not user_data:
        return jsonify({"error": "User not found"}), 404
    print("user_data:", user_data)
    user_id, name, email = user_data[0]

    # interaction_types = {
    #                     "likedMedia": {
    #                         "query": """
    #                             SELECT s.id, s.multimedia_type_id
    #                             FROM like l
    #                             JOIN Show s ON l.show_id = s.id
    #                             WHERE l.user_id = ?
    #                         """,
    #                         "moviesids": [],
    #                         "seriesids": []
    #                     },
    #                     "dislikedMedia": {
    #                         "query": """
    #                             SELECT s.id, s.multimedia_type_id
    #                             FROM dislike d
    #                             JOIN Show s ON d.show_id = s.id
    #                             WHERE d.user_id = ?
    #                         """,
    #                         "moviesids": [],
    #                         "seriesids": []
    #                     },
    #                     "blockedMedia": {
    #                         "query": """
    #                             SELECT s.id, s.multimedia_type_id
    #                             FROM blocked b
    #                             JOIN Show s ON b.show_id = s.id
    #                             WHERE b.user_id = ?
    #                         """,
    #                         "moviesids": [],
    #                         "seriesids": []
    #                     },
    #                     "watchLaterMedia": {
    #                         "query": """
    #                             SELECT s.id, s.multimedia_type_id
    #                             FROM watch_later w
    #                             JOIN Show s ON w.show_id = s.id
    #                             WHERE w.user_id = ?
    #                         """,
    #                         "moviesids": [],
    #                         "seriesids": []
    #                     }
    #                 }
    # test
    interaction_types = {
                        "likedMedia": {
                            "query": """
                                SELECT s.id, s.multimedia_type_id
                                FROM like l
                                JOIN Show s ON l.show_id = s.id
                                WHERE l.user_id = 1
                            """,
                            "moviesids": [],
                            "seriesids": []
                        },
                        "dislikedMedia": {
                            "query": """
                                SELECT s.id, s.multimedia_type_id
                                FROM dislike d
                                JOIN Show s ON d.show_id = s.id
                                WHERE d.user_id = 1
                            """,
                            "moviesids": [],
                            "seriesids": []
                        },
                        "blockedMedia": {
                            "query": """
                                SELECT s.id, s.multimedia_type_id
                                FROM blocked b
                                JOIN Show s ON b.show_id = s.id
                                WHERE b.user_id = 1
                            """,
                            "moviesids": [],
                            "seriesids": []
                        },
                        "watchLaterMedia": {
                            "query": """
                                SELECT s.id, s.multimedia_type_id
                                FROM watch_later w
                                JOIN Show s ON w.show_id = s.id
                                WHERE w.user_id = 1
                            """,
                            "moviesids": [],
                            "seriesids": []
                        }
                    }
    # print("interaction_types:", interaction_types)
    # Step 1: Base user info
    user_data = {}

    # Loop تضيف البيانات للميديا المناسبة
    for media_key, config in interaction_types.items():
        # results = sqlite_execute_query(database, config["query"], session["user_id"], fetch=True)
        # test
        results = sqlite_execute_query(database, config["query"], fetch=True , is_dict=True)

        print("results:", results)
        for show_id, media_type in results:
            if media_type == 1:
                config["moviesids"].append(show_id)
            elif media_type == 2:
                config["seriesids"].append(show_id)

    # بناء النتيجة النهائية
    user_data = {
        user_id: {
            "user_data": {
                "email_or_phone": email,
                "id": user_id,
                "name": name
            }
        }
    }

    # إضافة القوائم النهائية للنتيجة
    for media_key, config in interaction_types.items():
        user_data[user_id][media_key] = [
            {"media": "movie", "moviesids": config["moviesids"]},
            {"media": "series", "seriesids": config["seriesids"]}
        ]

    # إضافة رسائل لو مفيش حاجة في بعض القوائم
    messages = []
    for media_key in interaction_types:
        if not interaction_types[media_key]["moviesids"] and not interaction_types[media_key]["seriesids"]:
            msg = f"User has no {media_key.replace('Media', '').lower()} shows."
            messages.append(msg)

    # إرسال الاستجابة
    return jsonify({
        "user_data": user_data,
        "messages": messages
    }), 200

# get liked shows input from user and insert into database
@app.route("/api/like", methods=["POST"])
@csrf.exempt
def like_show():
    data = request.json
    user_id = session["user_id"]
    show_id = data.get("show_id")
    # Check if the user has already liked the show
    existing_like = sqlite_execute_query(database, "SELECT * FROM like WHERE user_id = ? AND show_id = ?", (user_id, show_id), fetch=True)
    if existing_like:
        return jsonify({"message": "Show already liked"}), 400
    else:
        # Insert the like into the database
        sqlite_execute_query(database, "INSERT INTO like (user_id, show_id) VALUES (?, ?)", (user_id, show_id))
        return jsonify({"message": "Show liked successfully"}), 200
    
# get liked shows input from user and insert into database
@csrf.exempt
@app.route("/api/dislike", methods=["POST"])
def dislike_show():
    data = request.json
    user_id = session["user_id"]
    show_id = data.get("show_id")
    # Check if the user has already disliked the show
    existing_dislike = sqlite_execute_query(database, "SELECT * FROM dislike WHERE user_id = ? AND show_id = ?", (user_id, show_id), fetch=True)
    if existing_dislike:
        return jsonify({"message": "Show already disliked"}), 400
    else:
        # Insert the dislike into the database
        sqlite_execute_query(database, "INSERT INTO dislike (user_id, show_id) VALUES (?, ?)", (user_id, show_id))
        return jsonify({"message": "Show disliked successfully"}), 200
    
# add to watch later
@csrf.exempt
@app.route("/api/watch-later", methods=["POST"])
def add_to_watch_later():
    data = request.json
    user_id = session["user_id"]
    show_id = data.get("show_id")
    
    # Check if the show is already in the watch later list
    existing_entry = sqlite_execute_query(database, "SELECT * FROM watch_later WHERE user_id = ? AND show_id = ?", (user_id, show_id), fetch=True)
    
    if existing_entry:
        return jsonify({"message": "Show already in watch later list"}), 400
    else:
        # Insert the show into the watch later list
        sqlite_execute_query(database, "INSERT INTO watch_later (user_id, show_id) VALUES (?, ?)", (user_id, show_id))
        return jsonify({"message": "Show added to watch later list"}), 200
    
    
# get category 