import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

import LandingPage from "./src/pages/landing";
import InputPage from "./src/pages/input";
import PuzzlePage from "./src/pages/puzzle";

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerShown: false,
        }}
      >
        <Stack.Screen name="Landing" component={LandingPage} />
        <Stack.Screen name="Input" component={InputPage} />
        <Stack.Screen name="Puzzle" component={PuzzlePage} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
