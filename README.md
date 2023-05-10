# README

To run the application you need installed Docker:

1. In terminal go to apps directory and build app by `docker compose build`.
2. Then run the command `docker compose up`
3. If everything has been installed, perform a migration `bundle exec rails db:migrate`
4. Application should be available at port 3000


To open the container terminal in VS Code:
1. Open local terminal
2. Run command `docker ps` and copy the container ID
3. Run command `docker exec -it <container ID> sh`

# TODO

0. General tasks
- [ ] Custom error pages
- [x] Close alert at unauthorized login status

2. User uploads
- [ ] More file icons

3. Crypto Dashboard
- [ ] More specific tests
- [ ] Filtering results
- [ ] Paginate results
- [ ] Modal with specific crypto data on click at the table row
