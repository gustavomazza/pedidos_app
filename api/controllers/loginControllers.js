const Config = require('../config/config')
const config = new Config();
const jwt = require('jsonwebtoken');


const Pool = require('pg').Pool
const pool = new Pool({
  user: config.user,
  host: config.host,
  database: config.database,
  password: config.password,
  port: config.port,
})


const postUsuario = (req, res) => {
    const { usuario, senha } = req.body
  
    pool.query(
      'select id_vendedor, nome, usuario, senha from vendedores where usuario = $1 and senha = $2',
      [usuario, senha],
      (error, results) => {
        if (error) {
          throw error
        } else if(results.rowCount == 0){
          res.status(404).send({mensagem: 'Acesso Negado'});
        } else{
            
            let token = jwt.sign({
              id: results.rows[0].id_vendedor,
              usuario: usuario
            }, 
            config.jwt_key,
            {
              expiresIn: "30m"
            })
            res.status(200).send({
              nome: results.rows[0].nome,
              mensagem: 'Autenticado com sucesso',
              token: token,

            })
        }
        
      }
    )
  }

module.exports = {
  
  postUsuario
  
}