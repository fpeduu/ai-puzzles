import { useEffect, useState } from "react";
import {
  StyleSheet,
  Text,
  View,
  Dimensions,
  Image,
  ActivityIndicator,
  Pressable,
} from "react-native";
import { Asset } from "expo-asset";
import * as ImgManipulator from "expo-image-manipulator";

const vh = Dimensions.get("window").height;
const vw = Dimensions.get("window").width;

export default function PuzzlePage({ route, navigation }) {
  const { input } = route.params;
  const [images, setImages] = useState([]);
  const [loading, setLoading] = useState(false);
  const [directions, setDirections] = useState([0, 0, 0, 0]);

  const rotateImage = async (imgIndex) => {
    const image = images[imgIndex];

    const newDirection = (directions[imgIndex] + 1) % 4;
    setDirections([
      ...directions.slice(0, imgIndex),
      newDirection,
      ...directions.slice(imgIndex + 1),
    ]);
    const manipResult = await ImgManipulator.manipulateAsync(
      image.localUri || image.uri,
      [
        { rotate: newDirection * 90 },
        { flip: ImgManipulator.FlipType.Vertical },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.PNG }
    );
    setImages([
      ...images.slice(0, imgIndex),
      manipResult,
      ...images.slice(imgIndex + 1),
    ]);
  };

  const cropImageInto4Parts = async () => {
    const image = Asset.fromModule(require("../assets/prompt-result.png"));
    await image.downloadAsync();

    const size = image.height / 2;

    const firstImg = await ImgManipulator.manipulateAsync(
      image.localUri || image.uri,
      [
        {
          crop: { originX: 0, originY: 0, width: size, height: size },
        },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const secondImg = await ImgManipulator.manipulateAsync(
      image.localUri || image.uri,
      [
        {
          crop: {
            originX: size,
            originY: 0,
            width: size,
            height: size,
          },
        },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const thirdImg = await ImgManipulator.manipulateAsync(
      image.localUri || image.uri,
      [
        {
          crop: {
            originX: 0,
            originY: size,
            width: size,
            height: size,
          },
        },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const fourthImg = await ImgManipulator.manipulateAsync(
      image.localUri || image.uri,
      [
        {
          crop: {
            originX: size,
            originY: size,
            width: size,
            height: size,
          },
        },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    setImages([firstImg, secondImg, thirdImg, fourthImg]);
    setLoading(false);
  };

  useEffect(() => {
    setLoading(true);
    cropImageInto4Parts();
  }, []);

  return (
    <View style={styles.container}>
      {loading ? (
        <ActivityIndicator size="large" color="#F8F1FF" />
      ) : (
        <>
          <Text style={styles.h1}>{input || ""}</Text>

          {images.map((img, i) => (
            <Pressable
              onPress={() => rotateImage(i)}
              style={{ ...styles.img, ...styles[`part${i + 1}`] }}
            >
              <Image source={img} style={styles.img} />
            </Pressable>
          ))}
        </>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#343434",
    alignItems: "center",
    justifyContent: "center",
  },
  h1: {
    color: "#F8F1FF",
    fontSize: 36,
    position: "absolute",
    zIndex: 2,
    top: vh * 0.1,
  },
  h2: {
    color: "#F8F1FF",
    fontSize: 20,
    position: "absolute",
    zIndex: 2,
    top: vh * 0.3,
  },
  img: {
    position: "absolute",
    zIndex: 1,
    width: (vw * 0.75) / 2,
    height: (vw * 0.75) / 2,
  },
  part1: {
    top: vh * 0.5 - (vw * 0.8) / 2,
    left: vw * 0.5 - (vw * 0.8) / 2,
  },
  part2: {
    top: vh * 0.5 - (vw * 0.8) / 2,
    right: vw * 0.5 - (vw * 0.8) / 2,
  },
  part3: {
    top: vh * 0.7 - (vw * 0.8) / 2,
    left: vw * 0.5 - (vw * 0.8) / 2,
  },
  part4: {
    top: vh * 0.7 - (vw * 0.8) / 2,
    right: vw * 0.5 - (vw * 0.8) / 2,
  },
});
