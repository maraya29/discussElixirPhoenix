defmodule Discuss.PageControllerTest do
  use Discuss.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~
             "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n    <meta name=\"description\" content=\"\">\n    <meta name=\"author\" content=\"\">\n\n    <title>Hello Discuss!</title>\n    <link rel=\"stylesheet\" href=\"/css/app.css\">\n    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.7/css/materialize.min.css\">\n    <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/icon?family=Material+Icons\">\n    <script>\n    </script>\n  </head>\n\n  <body>\n    <nav class=\"light-blue\">\n      <div class=\"nav-wrapper container\">\n        <a href=\"/\" class=\"brand-logo\">\n          Discussions\n        </a>\n        <ul class=\"right\">\n            <li>\n<a href=\"/auth/github\">Sign in with Github</a>            </li>\n        </ul>\n      </div>\n    </nav>\n    <div class=\"container\">\n\n      <p class=\"alert alert-info\" role=\"alert\"></p>\n      <p class=\"alert alert-danger\" role=\"alert\"></p>\n\n      <main role=\"main\">\n<h2>Topics</h2>\n\n<ul class=\"collection\">\n</ul>\n\n<div class=\"fixed-action-btn\">\n<a class=\"btn-floating btn-large waves-effect waves-light red\" href=\"/topics/new\">    <i class=\"material-icons\">add</i>\n</a>  </a>\n</div>\n      </main>\n\n    </div> <!-- /container -->\n    <script src=\"/js/app.js\"></script>\n  </body>\n</html>\n"
  end
end
