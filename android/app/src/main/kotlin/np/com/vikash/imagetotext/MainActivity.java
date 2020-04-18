package np.com.vikash.imagetotext;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import androidx.annotation.NonNull;

import com.google.firebase.ml.vision.FirebaseVision;
import com.google.firebase.ml.vision.common.FirebaseVisionImage;
import com.google.firebase.ml.vision.text.FirebaseVisionText;
import com.google.firebase.ml.vision.text.FirebaseVisionTextRecognizer;

import java.io.File;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "myAppChannel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("method")) {
                                String path = call.argument("data");
                                File file = new File(path);
                                Bitmap bitmap = BitmapFactory.decodeFile(file.getAbsolutePath(), new BitmapFactory.Options());

                                FirebaseVisionImage image = FirebaseVisionImage.fromBitmap(bitmap);
                                FirebaseVisionTextRecognizer recognizer = FirebaseVision.getInstance().getCloudTextRecognizer();
                                recognizer.processImage(image)
                                        .addOnSuccessListener(firebaseVisionText ->
                                                result.success(processTextRecognitionResult(firebaseVisionText)))
                                        .addOnFailureListener(e -> {
                                            e.printStackTrace();
                                        });

                            } else result.notImplemented();
                        }
                );
    }

    private String processTextRecognitionResult(FirebaseVisionText texts) {
        StringBuilder t = new StringBuilder();

        List<FirebaseVisionText.TextBlock> blocks = texts.getTextBlocks();
        if (blocks.size() == 0) {
            return "No text found";
        }

        for (int i = 0; i < blocks.size(); i++) {
            t.append(" ").append(blocks.get(i).getText());
        }

        return t.toString();
    }

}
