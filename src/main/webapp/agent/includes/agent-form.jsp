<form action="UpdateAgent" method="POST" class="form" enctype="multipart/form-data" accept-charset="UTF-8">
    <div class="form-row">
        <div class="form-group">
            <label for="imageURL">Profile Photo:</label>
            <input type="file" class="image-file" id="imageURL" name="imageURL" accept="image/*">
            <span id="imageURL-error" class="error-message"></span>
        </div>
        <div class="form-group">
            <label for="status">Status:</label>
            <select name="agentStatus" required>
                <option value="" disabled>Select Status</option>
                <option value="Online" selected>Online</option>
                <option value="Offline">Offline</option>
            </select>
            <span id="status-error" class="error-message"></span>
        </div>
    </div>
    <div class="right">
        <button type="submit" id="submitButton" class="button-29">Save Changes</button>
    </div>
    <div>
        <p>Profile Photo Preview:</p>
        <img id="imagePreview" src="" alt="Image preview" style="display: none; max-width: 200px; height: auto;" />
    </div>
</form>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const imageUrlInput = document.getElementById('imageURL');
        const imagePreview = document.getElementById('imagePreview');

        imageUrlInput.addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file && file.type.startsWith('image/')) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.src = e.target.result;
                    imagePreview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                imagePreview.src = '';
                imagePreview.style.display = 'none';
            }
        });
    });
</script>
