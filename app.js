const express = require('express');
const cors = require('cors');
const cookieParser = require('cookie-parser');

const authRoutes = require('./routes/auth.routes');
const usuariosRoutes = require('./routes/usuarios.routes');
const areaRoutes = require('./routes/area.routes');
const doctorRoutes = require('./routes/doctor.routes');
const horarioRoutes = require('./routes/horario.routes');
const servicioRoutes = require('./routes/servicio.routes');

const app = express();

app.use(express.json());
app.use(cookieParser());

app.use(cors({
  origin: [
    "http://localhost:3000",
    "https://frontend-psicologia-six.vercel.app"
  ],
  credentials: true
}));

app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/area', areaRoutes);
app.use('/api/v1/doctor', doctorRoutes);
app.use('/api/v1/horario', horarioRoutes);
app.use('/api/v1/servicio', servicioRoutes);


app.listen(4000, () => console.log('Servidor en puerto 4000'));
