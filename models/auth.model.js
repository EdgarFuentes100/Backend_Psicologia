const { localDB } = require('../config/db');

async function getUsuarioPorPin(pin) {
  const [rows] = await localDB.query(
    `
    SELECT
      u.idUsuario,
      CONCAT(p.nombres, ' ', p.apellidos) AS nombre,
      p.correo,
      r.nombre AS rol,
      p.idPersona,
      p.telefono,
      p.dui,
      p.fechaNacimiento,
      p.sexo,
      p.direccion,
      u.usuario,
      u.estado,
      u.fechaRegistro
    FROM usuarios u
    INNER JOIN personas p
      ON p.idUsuario = u.idUsuario
    INNER JOIN roles r
      ON r.idRol = u.idRol
    WHERE u.password = SHA2(?,256)
      AND u.estado = TRUE
    `,
    [pin]
  );

  return rows.length > 0 ? rows[0] : null;
}

module.exports = {
  getUsuarioPorPin,
};