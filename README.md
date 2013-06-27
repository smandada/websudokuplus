Web Sudoku Plus
===============

This project is built on
RVM (system pre requisite)
Ruby 1.9.2 (use RVM)
Rails 3.1.1 (Gemfile - installed by project)

After cloning the repo:
-----------------------
1. Update config/database.yml, with mysql socket location on your machine (/tmp/msql)
2. Create .rvmrc in the proj folder with 1.9.2@rails31ruby192 (create a new gemset rails31ruby192)
3. Install the gems using: bundle install
4. Run the project using: rails s -p 3000
5. Access the webpage: http://localhost:3000/

Test:
-----
http://staging2.claritics.com:3014/