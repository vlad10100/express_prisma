import morgan, {StreamOptions} from "morgan";

import Logger from "../utils/logger";

const stream: StreamOptions = {
    write: (message) => Logger.http(message)
}

const skip = () => {
    const ENV = process.env.NODE_ENV;
    return ENV !== 'development'
}

const morganMiddleware = morgan(
    ":method :url :status :res[content-length] - :response-time ms",
    {stream, skip}
)

export default morganMiddleware