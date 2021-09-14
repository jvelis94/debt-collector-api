## Split

Split (debt-collector) is an application that allows users to Split bills with their friends.

## Backend Technologies:

* Ruby on Rails
* Postgres
* Redis & SideKiq for background jobs


## Features include:

* Create and Sign into an account using JWT
* Create Bills
* In each bill, you can add friends that you would like to split the bill with
* As you add items, or update tax and gratuity: 
  * subtotals and totals are automatically updated
  * individual tax and gratuity dollar amounts are updated by proportion of total bill
* Once you finish the bill, you can share each individual breakdown via text, email, etc. This creates an automated message letting your friend know their total owed with a breakdown of items they consumed
* Once your friend has paid you back, you may mark them as paid
* Background jobs are utilized to email Bill creators every 72 hours until they update recipients as paid. This helps ensure that users can keep track of who owes them money
