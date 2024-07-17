public class ExportLogs {
    public static void exportLogs(@NonNull BufferedWriter writer) {
        Process process = null;
        try {
            process = Runtime.getRuntime().exec("logcat -d");
            copyStream(process, writer);
        }
        catch (IOException ignore) {}
        finally {
            if (process != null) {process.destroyForcibly();}
        }
    }

    private static void copyStream(@NonNull Process process, @NonNull BufferedWriter writer) throws IOException {
        String line;
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()))) {
            while ((line = reader.readLine()) != null) {writer.write(line);}
        }
    }
}