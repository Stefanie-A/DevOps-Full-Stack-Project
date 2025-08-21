import { Sequelize } from "sequelize";
import dotenv from 'dotenv';
dotenv.config();

const dbURL = process.env.DATABASE_URL;

if (!dbURL) {
    throw new Error("Database credentials missing");

};

const sequelize = new Sequelize(dbURL, {
    dialect: 'postgres',
    logging: false,
});

export default sequelize;