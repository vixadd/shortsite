Personal Website for David Kroell
---------------------------------

This is a personal website for David Kroell, but can be used by anyone looking to start out developing a web application.

Development
-----------
The program here involves a docker container. In-which, one can conduct all of the development needed to develop the web application.

Run the following:
$> make docker-start-dev-cpu

This will build the container for the user and will spawn a docker container.
Then there will be a docker container running. Confirm this with the following:

$> docker ps

Login to the active session by running the following:

$> make docker-login

