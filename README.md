# WorkRamp Take-Home: Full-Stack

## Important notes

Below is the necessary information to understand how each parte of the assignment was solved. **Please, take a look**.

## Part 1

The app is developed using React (with Vite), given that it's the technology used in the position I'm applying for. I also took care of properly configuring linting and formatting, so you can take a look at the configs to get and idea of the setup.

You can run the application in a local dev environment by using Node.js version 20.11.1 and running:

```lang-bash
$ npm run dev
```

The app has some data hardcoded, which is returned in promises to simulate the asynchronous nature of HTTP requests.

Following the user stories provided by the assignment, the app can add or remove content blocks using the buttons on the right sidebar. Everything else is hardcoded, since no other functionality was required.

## Part 2

You can find the Part 2 in the file `./api_design.txt`. I reused the types implemented in TypeScript in Part 1 to make the text more readable, reducing the bloat of writing all payloads. Please, refer to `./src/data/data.ts` to find each type definition.

## Part 3

You have the `./schema.sql` file, in which I defined all the database schema in plain SQL, since I find it cleaner than a custom syntax on a plain `.txt` file. There you have all the tables, relations and restrictions in the schema.

You also have a `./schema.png` file containing an ER diagram of the database, to give a more visual representation.

In the `./schema.sql` file I have added comments outlining the benefits of the option chosen, as indicated in the assignment.

## Thanks

Special thanks for the time taken to review this project. I hope you like it!
