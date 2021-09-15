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


const getPedidos = (req, res, next) => {

  pool.query('select pedidos.id_pedido, clientes.nome, pedidos.valor_total from pedidos ' +
    'inner join clientes on clientes.id_cliente = pedidos.id_cliente_fk ' +
    'order by id_pedido desc',
    
  (error, results) => {
    if (error) {
      throw error
    } else if(results.rowCount == 0){
      res.status(404).send({mensagem: 'erro pedidos'});
    } else{
        pool.query(
          'select sum(valor_total) AS total from pedidos',
            (error2, results2) => {
                if (error2) {
                    throw error
                  } else if(results2.rowCount == 0){
                    res.status(404).send({mensagem: 'erro valor total'});
                  } else{
                    res.status(200).send({
                        pedidosClientes: results.rows,
                        total: parseFloat(results2.rows[0].total),
        
                        
          
                      })
                      
                  }
            })
        
       
    }
    
  }
)

    
  }

module.exports = {
  
    getPedidos
  
}