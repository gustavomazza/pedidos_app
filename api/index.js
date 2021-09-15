const express = require('express')
const morgan = require('morgan')
const bodyParser = require('body-parser')

const app = express()
const loginDb = require('./controllers/loginControllers')
const pedidosDb = require('./controllers/pedidosControllers')

const port = 3011
const autenticacao = require('./middleware/login')


app.listen(port, () => {
  console.log(`App running on port ${port}.`)
})

app.use(morgan('dev'))
app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header(
    'Access-Control-Allow-Header', 
    'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    );

  if (req.method === 'OPTIONS') {
    res.header('Access-Control-Allow-Methods', 'PUT, POST, DELETE, GET');
    return res.status(200).send({});
  }

  next();
})



//Rota Padrão
app.get('/', (req, res) => {
  res.json({ info: 'Node.js, Express, and Postgres API' })
})

//Rotas Login
app.post('/login', loginDb.postUsuario)

//Rotas Pedidos
app.get('/pedidos', autenticacao.obrigatorio, pedidosDb.getPedidos)



//Quando não encontra a rota passada
app.use((req, res, next) => {
  const erro = new Error('Não encontrado');
  erro.status = 404;
  next(erro);
});

app.use((error, req, res, next) => {
  res.status(error.status || 500);
  return res.send({
    erro: {
      mensagem: error.message
    }
  });
});

