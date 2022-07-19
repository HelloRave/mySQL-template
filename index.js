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

    app.get('/search', async function(req, res){

        let query = 'SELECT * from actor WHERE 1';
        let bindings = []
        
        if (req.query.first_name) {
            query += ` AND first_name LIKE ?`
            bindings.push('%' + req.query.first_name + '%')
        }

        if (req.query.last_name) {
            query += ` AND last_name LIKE ?`
            bindings.push('%' + req.query.last_name + '%')
        }

        console.log(query, bindings) // XSS CSRF SQL injection

        let [actors] = await connection.execute(query, bindings);

        res.render('search', {
            'actors': actors
        })
    })
    
    app.get('/category', async function(req, res){
        const [category] = await connection.execute('SELECT * from category')
        res.render('category',{
            category: category
        })
    })

    app.post('/category', async function(req, res){
        const query = 'INSERT INTO category (name) values (?)'
        const bindings = [req.body.name]
        await connection.execute(query, bindings)
        res.redirect('/category')
    })

    app.get('/category/:category_id/update', async function(req, res){
        const query = 'SELECT * from category WHERE category_id = ?'
        const bindings = [req.params.category_id]
        let [categories] = await connection.execute(query, bindings)

        res.render('update-category',{
            categories: categories[0]
        })
    })

    app.post('/category/:category_id/update', async function(req, res){
        const query = 'UPDATE category SET name = ? WHERE category_id = ?'
        const bindings = [req.body.name, req.params.category_id]
        await connection.execute(query, bindings)

        res.redirect('/category')
    })
}
main();

app.listen(3000, function(){
    console.log("Server started")
})


// CREATE USER 'ahkow'@'localhost' IDENTIFIED BY 'rotiprata123';
// GRANT ALL PRIVILEGES ON *.* TO 'ahkow'@'localhost' WITH GRANT OPTION;