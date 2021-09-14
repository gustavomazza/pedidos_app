const jwt = require('jsonwebtoken');
const Config = require('../config/config')
const config = new Config();

exports.obrigatorio = (req, res, next) => {

    try {
        const token = req.headers.authorization.split(' ')[1];
        const decode = jwt.verify(token, config.jwt_key);
        req.nome = decode;
        
        next();
    } catch (error) {
        // const decode = jwt.verify(req.body.token, config.jwt_key);
        // req.nome = decode;
        return res.status(401).send({mensagem: 'Falha na autenticação'})
    }
    
}