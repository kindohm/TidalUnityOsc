-- custom osc send to unity

module UnityOsc where
import Sound.Tidal.Stream
import Sound.Tidal.Pattern
import Sound.Tidal.Parse
import Sound.Tidal.OscStream

port = 5000

testShape = Shape {
  params = [
    S "thing" Nothing,
    F "x" (Just 0),
    F "y" (Just 0),
    F "z" (Just 0),
    F "duration" (Just 0.5)
  ],
  cpsStamp = True,
  latency = 0.38
}

testSlang = OscSlang {
  path = "/unity_osc",
  timestamp = NoStamp,
  namedParams = False,
  preamble = []
}

testStream = do
  s <- makeConnection "127.0.0.1" port testSlang
  stream (Backend s $ (\_ _ _ -> return ())) testShape

thing = makeS testShape "thing"
x = makeF testShape "x"
y = makeF testShape "y"
z = makeF testShape "z"
duration = makeF testShape "duration"
