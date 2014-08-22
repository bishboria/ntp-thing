import           Control.Monad            (liftM)
import           Network.BSD
import qualified Network.Socket     as NS
import           System.Posix.Env (getEnvDefault)

hostSocketAddress host port = do
  hostEntry <- getHostByName host
  return $ NS.SockAddrInet port (hostAddress hostEntry)

sendMessage socketAddress message = do
  sendSocket <- NS.socket NS.AF_INET NS.Datagram NS.defaultProtocol
  NS.sendTo sendSocket message socketAddress

main = do
  host <- getEnvDefault "HOST" "localhost"
  port <- liftM read $ getEnvDefault "PORT" "123"
  addr <- hostSocketAddress host (toEnum port)
  sendMessage addr "hello"
