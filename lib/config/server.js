const express = require('express');
const app = express();
const db = require('./db.js');
const bodyParser = require('body-parser');
const PORT = process.env.PORT || "4000";
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.json());

app.post('/login', (req, res) => {
    const { id, pw } = req.body;

    // 쿼리문을 작성하여 id와 pw가 일치하는 사용자가 있는지 확인합니다.
    db.query('select * from user where user_id = ? and user_pw = ?', [id, pw], (err, data) => {
        if (err) {
            console.error(err);
            return res.status(500).send({ message: '서버 에러' });
        }
        if (data.length > 0) {
            res.status(200).send(data[0]);
        } else {
            res.status(401).send({ message: '일치하는 정보가 없습니다' });
        }
    });
});

app.listen(PORT, () => {
    console.log(`Server On http://localhost:${PORT}`);
});
