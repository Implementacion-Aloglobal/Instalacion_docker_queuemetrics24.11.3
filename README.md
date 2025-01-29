```
            _                    ____   __  __  ___   _  _         _               _               
     /\    | |                  / __ \ |  \/  ||__ \ | || |       | |             | |              
    /  \   | |  ___    ______  | |  | || \  / |   ) || || |_    __| |  ___    ___ | | __ ___  _ __ 
   / /\ \  | | / _ \  |______| | |  | || |\/| |  / / |__   _|  / _` | / _ \  / __|| |/ // _ \| '__|
  / ____ \ | || (_) |          | |__| || |  | | / /_    | |   | (_| || (_) || (__ |   <|  __/| |   
 /_/    \_\|_| \___/            \___\_\|_|  |_||____|   |_|    \__,_| \___/  \___||_|\_\\___||_|   
QueueMetrics24 via Docker - ALO Global
```

Este documento detalla los pasos necesarios para instalar y configurar **QueueMetrics** en un entorno Docker sobre **Debian 12**.

---

### **Instalación de Docker en Debian 12**

#### 1. Actualiza los paquetes del sistema:
```bash
sudo apt update && sudo apt upgrade -y
```

#### 2. Instala los paquetes necesarios para Docker:
```bash
sudo apt install -y ca-certificates curl gnupg lsb-release
```

#### 3. Añade la clave GPG oficial de Docker:
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

#### 4. Configura el repositorio de Docker:
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

#### 5. Instala Docker:
```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

#### 6. Verifica que Docker está instalado correctamente:
```bash
docker --version
```

---

### **Crear un directorio para los datos persistentes**

Crea un directorio donde se almacenarán los datos persistentes de **QueueMetrics**:
```bash
sudo mkdir -p /opt/qm1data
sudo chown 1000:1000 /opt/qm1data
```
---
El uso de 1000:1000 en el comando chown se refiere al UID (User ID) y GID (Group ID) del usuario que ejecutará el contenedor. Es importante porque los contenedores de Docker suelen ejecutarse con un usuario específico dentro del contenedor, y este usuario necesita permisos para acceder y escribir en el volumen montado.

### **Descargar y ejecutar la imagen de QueueMetrics**

Ejecuta el siguiente comando para iniciar un contenedor de QueueMetrics con la configuración deseada:
```bash
#docker run --name=QM1 --volume=/opt/qm1data:/data --hostname=qm1 --memory=1024m --cpus=2 -e TZ="America/Bogota"  --network=host -d loway/queuemetrics:latest
#docker run  -e CFG='{"memory":400,"timezone":"GMT"}'  --name=QM1 --volume=/opt/qm1data:/data  --hostname=qm1  --network=host -d loway/queuemetrics:latest
docker run  -e CFG='{"memory":1024,"timezone":"America/Bogota"}'  --name=QM1 --volume=/opt/qm1data:/data  --hostname=qm1  --network=host -d loway/queuemetrics:latest

```

---

### **Verificar el estado del contenedor**

#### 1. Verifica que el contenedor esté corriendo:
```bash
docker ps
```

#### 2. Si necesitas acceder al contenedor para inspección o configuración avanzada:
```bash
docker exec -it QM1 bash
```

---

### **Detener y eliminar el contenedor**

#### Para iniciar el contenedor:
```bash
docker start QM1
```


#### Para detener el contenedor:
```bash
docker stop QM1
```

#### Para eliminar el contenedor:
```bash
docker rm QM1
```

> **Nota:** Los datos persistentes no se eliminarán porque están almacenados en `/opt/qm1data`.

---

### **Herramientas de monitoreo**

#### 1. Ver detalles específicos de un contenedor:
```bash
docker inspect QM1
```

#### 2. Ver el uso de recursos en tiempo real:
```bash
docker stats QM1
```

---

## ¡Y listo!

Ahora tienes instalado y funcionando **QueueMetrics** en Docker con configuración personalizada. Para cualquier duda, consulta la [documentación oficial de QueueMetrics](https://www.queuemetrics.com/docs/) o contacta con **ALOGlobal**.

ogalaviz 012025

