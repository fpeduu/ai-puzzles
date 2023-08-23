import { useEffect, useState } from "react";
import {
  StyleSheet,
  Text,
  View,
  Dimensions,
  Image,
  Pressable,
} from "react-native";
import { Asset } from "expo-asset";
import * as ImgManipulator from "expo-image-manipulator";
import axios from "axios";
import { ActivityIndicator } from "react-native";

const vh = Dimensions.get("window").height;
const vw = Dimensions.get("window").width;

export default function PuzzlePage({ route, navigation }) {
  const { input } = route.params;
  const [images, setImages] = useState([]);
  const [loading, setLoading] = useState(false);
  const [directions, setDirections] = useState([
    Math.floor(Math.random() * 4),
    Math.floor(Math.random() * 4),
    Math.floor(Math.random() * 4),
    Math.floor(Math.random() * 4),
    Math.floor(Math.random() * 4),
    Math.floor(Math.random() * 4),
    Math.floor(Math.random() * 4),
    Math.floor(Math.random() * 4),
    Math.floor(Math.random() * 4),
  ]);

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
      [{ rotate: 90 }],
      { compress: 1, format: ImgManipulator.SaveFormat.PNG }
    );
    setImages([
      ...images.slice(0, imgIndex),
      manipResult,
      ...images.slice(imgIndex + 1),
    ]);
  };

  const cropImage = async (imgUri) => {
    const image = Asset.fromModule(require("../assets/prompt-result.png"));
    await image.downloadAsync();

    const size = image.height / 3;

    const firstImg = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: { originX: 0, originY: 0, width: size, height: size },
        },
        { rotate: directions[0] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const secondImg = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: {
            originX: size,
            originY: 0,
            width: size,
            height: size,
          },
        },
        { rotate: directions[1] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const thirdImg = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: {
            originX: size * 2,
            originY: 0,
            width: size,
            height: size,
          },
        },
        { rotate: directions[2] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const fourthImg = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: {
            originX: 0,
            originY: size,
            width: size,
            height: size,
          },
        },
        { rotate: directions[3] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const fifthImg = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: {
            originX: size,
            originY: size,
            width: size,
            height: size,
          },
        },
        { rotate: directions[4] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const sixthImg = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: {
            originX: size * 2,
            originY: size,
            width: size,
            height: size,
          },
        },
        { rotate: directions[5] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const seventhImg = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: {
            originX: 0,
            originY: size * 2,
            width: size,
            height: size,
          },
        },
        { rotate: directions[6] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const eigth = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: {
            originX: size,
            originY: size * 2,
            width: size,
            height: size,
          },
        },
        { rotate: directions[7] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    const ninthImg = await ImgManipulator.manipulateAsync(
      imgUri,
      [
        {
          crop: {
            originX: size * 2,
            originY: size * 2,
            width: size,
            height: size,
          },
        },
        { rotate: directions[8] * 90 },
      ],
      { compress: 1, format: ImgManipulator.SaveFormat.JPEG }
    );

    setImages([
      firstImg,
      secondImg,
      thirdImg,
      fourthImg,
      fifthImg,
      sixthImg,
      seventhImg,
      eigth,
      ninthImg,
    ]);
    setLoading(false);
  };

  useEffect(() => {
    async function loadImages() {
      const apiKey =
        "yYTIEoz3kXHQBvIIXRI8TojE7bqUcw8mAzELOJUcx1UuFdoRz5sI8BSdMVFB";
      const url = "https://stablediffusionapi.com/api/v3/text2img";

      // const response = await axios.post(url, {
      //   key: apiKey,
      //   prompt: input,
      //   width: 512,
      //   height: 512,
      // });

      const image = Asset.fromModule(require("../assets/prompt-result.png"));
      await image.downloadAsync();

      // cropImage(response.data.output[0]);
      cropImage(image.localUri || image.uri);
    }

    loadImages();

    setLoading(true);
  }, []);

  useEffect(() => {
    if (
      directions[0] == 0 &&
      directions[1] == 0 &&
      directions[2] == 0 &&
      directions[3] == 0 &&
      directions[4] == 0 &&
      directions[5] == 0 &&
      directions[6] == 0 &&
      directions[7] == 0 &&
      directions[8] == 0
    )
      alert("Congratulations, You've finished your first puzzle!");
  }, [directions]);

  return (
    <View style={styles.container}>
      {loading ? (
        <ActivityIndicator size="large" color="#F8F1FF" />
      ) : (
        <>
          <Text style={styles.h1}>Here's your puzzle!</Text>

          <Text style={styles.h2}>
            {`Tap on a piece to rotate it. 
Prompt: "${input}"
            `}
          </Text>

          {images.map((img, i) => (
            <Pressable
              key={i}
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
    textAlign: "center",
    color: "#F8F1FF",
    fontSize: 20,
    position: "absolute",
    zIndex: 2,
    top: vh * 0.1 + 50,
  },
  img: {
    position: "absolute",
    zIndex: 1,
    width: (vw * 0.8) / 3,
    height: (vw * 0.8) / 3,
  },
  part1: {
    top: vh * 0.5 - (vw * 0.8) / 2,
    left: vw * 0.5 - (vw * 0.8) / 2,
  },
  part2: {
    top: vh * 0.5 - (vw * 0.8) / 2,
  },
  part3: {
    top: vh * 0.5 - (vw * 0.8) / 2,
    right: vw * 0.5 - (vw * 0.8) / 2,
  },
  part4: {
    top: vh * 0.5 - (vw * 0.8) / 6,
    left: vw * 0.5 - (vw * 0.8) / 2,
  },
  part5: {
    top: vh * 0.5 - (vw * 0.8) / 6,
  },
  part6: {
    top: vh * 0.5 - (vw * 0.8) / 6,
    right: vw * 0.5 - (vw * 0.8) / 2,
  },
  part7: {
    top: vh * 0.5 + (vw * 0.8) / 6,
    left: vw * 0.5 - (vw * 0.8) / 2,
  },
  part8: {
    top: vh * 0.5 + (vw * 0.8) / 6,
  },
  part9: {
    top: vh * 0.5 + (vw * 0.8) / 6,
    right: vw * 0.5 - (vw * 0.8) / 2,
  },
});
