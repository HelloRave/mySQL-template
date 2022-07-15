const express = require('express')
const hbs = require('hbs')
const wax = require('wax-on')
const mysql2 = require('mysql2/promise')
require('dotenv').config()

const app = express();
app.set('view engine', 'hbs');
wax.on(hbs.handlebars);
wax.setLayoutPath('./views/layouts')

app.use(express.urlencoded({
    'extended': false
}))

async function main(){
    const connection = await mysql2.createConnection({
        'host': process.env.DB_HOST,
        'user': process.env.DB_USER,
        'database': process.env.DB_DATABASE,
        'password': process.env.DB_PASSWORD
    })

    app.get('/actors', async function(req, res){
        const [actors] = await connection.execute('SELECT * FROM actor')

        res.render('actors', {
            'actors': actors
        })
    })

    app.get('/staff', async function(req,res){
        const [staff] = await connection.execute('SELECT staff_id, first_name, last_name, email FROM staff')

        res.render('staff', {
            'staff': staff
        })
    })

    
}
main();

app.listen(3000, function(){
    console.log("Server started")
})


// CREATE USER 'ahkow'@'localhost' IDENTIFIED BY 'rotiprata123';
// GRANT ALL PRIVILEGES ON *.* TO 'ahkow'@'localhost' WITH GRANT OPTION;